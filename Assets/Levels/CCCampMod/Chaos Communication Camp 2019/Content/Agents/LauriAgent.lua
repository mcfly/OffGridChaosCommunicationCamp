Agent =
{
  world =
  {
    -- GotInebriated - go to whiskyleaks
    { state = "GotInebriated", value = false },
    -- PlayedSomeTunes - dispensed techno
    { state = "PlayedSomeTunes", value = false },
    -- Danced
    { state = "Danced", value = true },
    -- GiveATalk
    { state = "GaveATalk", value = false },
    -- WatchHackers (in the rummery)
    { state = "WatchedHackers", value = false },
  },

  actions =
  {
    {-- DrinkingWhisky Action
        name = "DrinkingWhisky",
        gesture = "UseCoffeeMachine",
        audio = "Play_Laptop_Download",
        required =
        {
          { state = "GotInebriated", value = false },
        },
        effect = { state = "GotInebriated", value = true },
        -- targetPlayer = true,
    },
    {-- Dancing Action
        name = "Dancing",
        gesture = "DanceSalsa",
        --audio = "Play_Laptop_Download",
        required =
        {
          { state = "Danced", value = false },
        },
        effect = { state = "Danced", value = true },
        -- targetPlayer = true,
    },
    {-- Watching A Talk Action
        name = "WatchingATalk",
        gesture = "LookAround",
        --audio = "Play_Laptop_Download",
        required =
        {
          { state = "usedPlaceAtATalk", value = false },
        },
        effect = { state = "usedPlaceAtATalk", value = true },

        -- targetPlayer = true,
    },
    {-- Coffee Action
        name = "Coffee",
        gesture = "UseCoffeeMachine",
        --audio = "Play_Laptop_Download",
        required =
        {
          { state = "hasMotivation", value = false },
          { state = "usedPlaceAtATalk", value = true },
        },
        effect = { state = "hasMotivation", value = true },
    },
    {-- Use Soldering Iron Action
        name = "Soldering",
        gesture = "PickupMed",
        --audio = "Play_Laptop_Download",
        required =
        {
          { state = "usedSolderingIron", value = false },
          { state = "usedCoffee", value = true },
        },
        effect = { state = "usedSolderingIron", value = true },
        -- targetPlayer = true,
    },
  },

  goals =
  {
    {-- Dance
      goal =
      {
        { state = "Danced", value = true },
      },
      interrupts = true,
      priority = 90,
      onCompletion =
      {
          -- Loop dancing until broken out of it?
          --{ state = "Danced", value = false },
      }
    },
    { --GOAL for motivation
     goal =
      {
        { state = "hasMotivation", value = true },
      },
      priority = 25,
    },
    {-- loop using beer tap, whisky bottle and DevMachine
      goal =
      {
        { state = "usedLawfulInterceptBeerTap", value = true },
        -- { state = "GreetedJoe", value = true },
        -- { state = "AnsweredIntercom", value = true },
      },
      interrupts = false,
      priority = 10,
      onCompletion =
      {
        { state = "usedLawfulInterceptBeerTap", value = false },
        { state = "usedWhiskyBottlesInterest", value = false },
        { state = "usedDevMachine", value = false },
      }
    },
    {-- loop using talk tent, coffee and harwarehacking village
      goal =
      {
        { state = "usedCoffee", value = true },
      },
      interrupts = false,
      priority = 10,
      onCompletion =
      {
        { state = "usedCoffee", value = false },
        { state = "usedPlaceAtATalk", value = false },
        { state = "usedSolderingIron", value = false },
      }
    },
    {-- Patrol Goal
      goal =
      {
        { state = "patrolCompleted", value = true },
      },
      priority = 10,
      onCompletion =
      {
        { state = "patrolCompleted", value = false },
      }
    },
    {-- this is a backstop goal that sends the NPC to the dest of everything else fails
      goal =
      {
        { state = "usedReceptionDeskInterest", value = true},
        -- { state = "GreetedJoe", value = true},
      },
      interrupts = true,
      priority = 1, -- low priority
      onCompletion =
      {
        { state = "usedReceptionDeskInterest", value = false},
      }
    },
  },

  canUse =
  {
    --[[ requirements here must be absolute and need completion before the next
    action can be done - this will create a chain of events
    e.g. get cup, pour tea, drink tea.
    DO NOT put requirements in actions if you dont want them to stop the action
    from occuring ]]
    -- {--Phone Charger Interst Point
    --   interest = "PhoneCharger",
    --   gesture = "StandingAmokDeviceHit",
      -- TODO This event is a placeholder - Audio events need setting up to work in CanUse actions (with interest point handling the event based on its state?)
    --   audio = "Play_VO_Secretary_LookIToldYouTooMany",
    -- },
    {--FilingCabinet Interest Point
      interest = "LawfulInterceptBeerTap",
      required = { state = "usedWhiskyBottlesInterest", value = true },
      -- TODO This event is a placeholder - Audio events need setting up to work in CanUse actions (with interest point handling the event based on its state?)
      audio = "Play_VO_Secretary_IHaveSomeFilingToDo",
      gesture = "UseCoffeeMachine",
    },
    {--Printer Interest Point
      interest = "WhiskyBottlesInterest",
      required = { state = "usedDevMachine", value = true },
      -- TODO This event is a placeholder - Audio events need setting up to work in CanUse actions (with interest point handling the event based on its state?)
      audio = "Play_VO_Secretary_BloodyPrinter",
      gesture = "StandingLookAtHipHeight",
    },
    {--DevMachine Interest Point
      interest = "DevMachine",
      -- TODO This event is a placeholder - Audio events need setting up to work in CanUse actions (with interest point handling the event based on its state?)
      audio = "Play_VO_Secretary_Didntknowyouwherein",
      gesture = "StandingTypingCalm",
    },
    {--ReceptionDesk Interest Point
      interest = "ReceptionDeskInterest",
      -- TODO This event is a placeholder - Audio events need setting up to work in CanUse actions (with interest point handling the event based on its state?)
      audio = "Play_VO_Secretary_FaxMachineIsOnTheBrink",
      gesture = "LookAtPhone",
    },
    -- {--ReceptionDesk Interest Point
    --   interest = "CoffeeMaker-Kitchen_01",
    --   -- TODO This event is a placeholder - Audio events need setting up to work in CanUse actions (with interest point handling the event based on its state?)
    --   audio = "Play_VO_Secretary_FaxMachineIsOnTheBrink",
    --   gesture = "StandingLookAtHipHeight",
    -- },
    {
      interest = "Coffee",
      effect = { state = "hasMotivation", value = true },
      personalityEffect =
      {
        { stat = "motivation", adjust = 1.0 },
        { stat = "bladder", adjust = 0.1 },
        { stat = "energy", adjust = 1.0 },
      },
      gesture = "UseCoffeeMachine",
    },
  },
  canFix = {	},
}
