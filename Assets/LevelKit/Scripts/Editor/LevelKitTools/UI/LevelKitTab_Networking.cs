// Copyright Semaeopus Ltd. 2017
// This code was created as part of LevelKit on: 2019-11-26 - 9:25
// DO NOT EDIT THIS FILE - Code changes will NOT be picked up and may break your project
// Visit http://wiki.offgridthegame.com for help - Happy Hacking!

#if LEVEL_KIT && UNITY_EDITOR

using System;
using System.IO;
using UnityEngine;
using UnityEditor;
using LevelKitNet;

[Serializable]
public class LevelKitTab_Networking : LevelKitTabBase 
{
    [SerializeField]
    private bool isConnected = false;
    private Client client = null;
    private readonly UploadModMsg modInfo = new UploadModMsg();
    private BuildInformationMsg buildInfo = new BuildInformationMsg();
    private ProgressMsg progressInfo = new ProgressMsg();

    public LevelKitTab_Networking(LevelKitTool tool) 
        : base(tool, TabAvailability.All)
    {
    }

    public override void Draw()
    {
        // Lazy init the client
        if (client == null)
        {
            client = new Client();
            client.RegisterCallback<SendLogMsg>(OnLog);
            client.RegisterCallback<ProgressMsg>(OnProgress);
            client.RegisterCallback<ClearProgressMsg>(OnProgressClear);
            client.RegisterCallback<BuildInformationMsg>(OnBuildInfo);
            client.RegisterCallback<CompletedUploadMsg>(OnUploadCompleted);
            client.RegisterCallback<ConnectMsg>(OnConnected);
            client.RegisterCallback<AIExplorerDataMsg>(OnAIExplorerData);

            // Pick up where we left off
            if (isConnected)
            {
                client.Connect();
            }
        }
        
        isConnected = client.isConnected();
        client.Update();

        DrawLevelKitLink();
        DrawModUplod();
    }

    private void DrawLevelKitLink()
    {
        string status = string.Empty;

        if (client.isConnected()) status = "Connected";
        else if (client.IsConnecting()) status = "Connecting";
        else if (!client.isConnected()) status = "Not Connected";

        GUILayout.Label(string.Format("LevelKit Link: {0}", status), EditorStyles.boldLabel);

        GUILayout.BeginVertical("Box");

        bool uploadInProgress = progressInfo.progress >= 0;
        GUI.enabled = !uploadInProgress;

        if (client.IsConnecting())
        {
            if (GUILayout.Button("Stop searching"))
            {
                client.Disconnect();
            }
        }
        else if (!client.isConnected())
        {
            if (GUILayout.Button("Search for game"))
            {
                client.Connect();
            }
        }
        else
        {
            if (GUILayout.Button("Stop Networking"))
            {
                client.Disconnect();
            }

            if (client.isConnected())
            {
                if (GUILayout.Button("Start"))
                {
                    client.Send(new StartMissionMsg {missionPath = Path.GetFullPath(m_Tool.fullLevelPath)});
                }

                if (GUILayout.Button("Stop"))
                {
                    client.Send(new StopMissionMsg());
                }

                if(GUILayout.Button("Update AI Explorer (Experimental)"))
                {
                    client.Send(new AIExplorerMsg() { on = true } );
                }
                /*if (GUILayout.Button("Disable AI Explorer"))
                {
                    client.Send(new AIExplorerMsg() { on = false });
                }*/
            }
        }
        
        GUI.enabled = true;
        
        GUILayout.EndVertical();
    }

    private void DrawModUplod()
    {
        if (!client.isConnected())
        {
            return;
        }
        
        GUILayout.Label("Mod Uploading", EditorStyles.boldLabel);
        GUILayout.BeginVertical("Box");


        if (buildInfo.platform == "STEAM")
        {
            bool uploadInProgress = progressInfo.progress >= 0;

            GUI.enabled = !uploadInProgress;

            ModDefinition currentMod = m_Tool.currentMod;


            currentMod.modIcon = (Texture2D) EditorGUILayout.ObjectField("Mod Icon", currentMod.modIcon, typeof(Texture2D), false);
            currentMod.name = EditorGUILayout.DelayedTextField("Mod Name",currentMod.name);
            currentMod.description = EditorGUILayout.DelayedTextField("Mod Description", currentMod.description);
            
            modInfo.visibility =
                (UploadModMsg.Visibility) EditorGUILayout.EnumPopup("Visibility", modInfo.visibility);
            
            if (!m_Tool.isInLevelKitLevel)
            {
                if (GUILayout.Button("Select path"))
                {
                    modInfo.modPath = EditorUtility.OpenFolderPanel("Select App", "Assets/Apps", string.Empty);
                    if (!string.IsNullOrEmpty(modInfo.modPath))
                    {
                        string modJsonPath = Path.Combine(modInfo.modPath, "mod.json");
                        if (File.Exists(modJsonPath))
                        {
                            m_Tool.currentMod = JsonUtility.FromJson<ModDefinition>(File.ReadAllText(modJsonPath));
                            // Load the mods icon is it's valid
                            if (!string.IsNullOrEmpty(m_Tool.currentMod.iconPath))
                            {
                                m_Tool.currentMod.modIcon = AssetDatabase.LoadAssetAtPath<Texture2D>(m_Tool.currentMod.iconPath);
                            }
                        }
                        else
                        {
                            Debug.LogErrorFormat("Expected mod.json at path '{0}'", modJsonPath);
                        }
                    }
                }
                EditorGUILayout.LabelField("App path", modInfo.modPath);
            }
            
            GUILayout.Label("By submitting this item, you agree to the workshop terms of service", EditorStyles.centeredGreyMiniLabel);
            
            GUILayout.BeginHorizontal();
            {
                modInfo.definition = m_Tool.currentMod;

                string uploadPrefix = modInfo.definition.id == 0
                    ? "Create and upload mod to Steam Workshop"
                    : "Update Mod on Steam Workshop";
                
                if (GUILayout.Button(uploadPrefix))
                {
                    if (m_Tool.isInLevelKitLevel)
                    {
                        string modTempPath = Path.Combine(Path.GetTempPath(), Path.GetFileName(m_Tool.fullModPath));

                        // Copy over mod folder to temp directory, remove the scene folder and meta files
                        LevelKitUtils.CopyDirectory(m_Tool.fullModPath,
                            modTempPath,
                            file => file.Extension != ".meta",
                            directory => directory.Name != "Scene");
                        
                        LevelKitUtils.RemoveReadonly(modTempPath, true);

                        modInfo.modPath = modTempPath;
                        
                        m_Tool.SaveModJsonChanges();
                    }
                    
                    if (currentMod.modIcon)
                    {
                        modInfo.iconPath = Path.GetFullPath(AssetDatabase.GetAssetPath(currentMod.modIcon));
                    }
                    
                    client.Send(modInfo);
                }
                if (GUILayout.Button("Read terms of service"))
                {
                    Application.OpenURL("http://steamcommunity.com/sharedfiles/workshoplegalagreement");
                }
            }
            GUILayout.EndHorizontal();

            GUI.enabled = true;

            if (uploadInProgress)
            {
                Rect rect = GUILayoutUtility.GetRect(18, 18, "TextField");
                EditorGUI.ProgressBar(rect, progressInfo.progress / 100f, progressInfo.progressText);
            }
        }
        else
        {
            EditorGUILayout.LabelField("Game must be Steam client in order to upload your mod.", EditorStyles.centeredGreyMiniLabel);
        }

        GUILayout.EndVertical();
    }

    private static void OnLog(NetMessage message)
    {
        SendLogMsg msg = (SendLogMsg) message;

        switch (msg.logType)
        {
            case LogType.Error:
                Debug.LogError(msg.logMessage);
                break;
            case LogType.Warning:
                Debug.LogWarning(msg.logMessage);
                break;
            case LogType.Log:
                Debug.Log(msg.logMessage);
                break;
        }
    }

    private void OnProgress(NetMessage message)
    {
        progressInfo = (ProgressMsg) message;
    }

    private void OnProgressClear(NetMessage message)
    {
        progressInfo.progress = -1;
        progressInfo.progressText = string.Empty;
    }

    private void OnBuildInfo(NetMessage message)
    {
        buildInfo = (BuildInformationMsg)message;
    }

    private static void OnUploadCompleted(NetMessage message)
    {
        CompletedUploadMsg completedMsg = (CompletedUploadMsg) message;
        if (completedMsg.wasSuccess)
        {
            // As the folder passed back is in a temp directory, work out what mod was uploaded
            string modName = Path.GetFileName(completedMsg.modPath);
            
            // Try mission mod first 
            string modPath = Path.Combine("Assets/Levels", modName);
            
            // Otherwise try apps folder
            if (!Directory.Exists(modPath))
            {
                modPath = Path.Combine("Assets/Apps", modName);
            }

            if (Directory.Exists(modPath))
            {
                string modJsonPath = Path.Combine(modPath, "mod.json");
                if (LevelKitUtils.VCSCheckoutPath(modJsonPath))
                {
                    ModDefinition definition = JsonUtility.FromJson<ModDefinition>(File.ReadAllText(modJsonPath));

                    definition.id = completedMsg.id;

                    File.WriteAllText(modJsonPath, JsonUtility.ToJson(definition, true));
                }
                else
                {
                    Debug.LogErrorFormat("Failed to complete checkout of file at '{0}'", modJsonPath);
                }

                Application.OpenURL("steam://url/CommunityFilePage/" + completedMsg.id);
            }
            else
            {
                Debug.LogErrorFormat("No mod with name {0} found to attach id {1} to", modName, completedMsg.id);
            }
            
            // Check we don't delete anything inside the Unity project
            // This also stops apps from being deleted when they're uploaded
            if (Directory.Exists(completedMsg.modPath) 
                && !completedMsg.modPath.StartsWith(Application.dataPath))
            {
                Directory.Delete(completedMsg.modPath, true);
            }
        }
    }

    private void OnConnected(NetMessage message)
    {
        CurrentModsMsg modsMsg = new CurrentModsMsg();
        
        // Apps
        foreach (string app in Directory.GetDirectories("Assets/Apps"))
        {
            if(!app.EndsWith("_template"))
            {
                modsMsg.modPaths.Add(Path.GetFullPath(app));
            }
        }
        
        // Missions
        foreach (string mission in Directory.GetDirectories("Assets/Levels"))
        {
            if(!mission.EndsWith("_template"))
            {
                modsMsg.modPaths.Add(Path.GetFullPath(mission));
            }        
        }

        client.Send(modsMsg);
    }

    private void OnAIExplorerData(NetMessage message)
    {
        AIExplorerDataMsg aiMsg = message as AIExplorerDataMsg;

        if(aiMsg != null)
        {
            AIExplorer.LevelKitData = aiMsg.data;
        }
    }
}

#endif // LEVEL_KIT && UNITY_EDITOR
