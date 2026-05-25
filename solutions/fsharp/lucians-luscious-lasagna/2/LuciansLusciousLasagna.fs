module LuciansLusciousLasagna

let expectedMinutesInOven = 40

let remainingMinutesInOven currentMinutesInOven =
    expectedMinutesInOven - currentMinutesInOven

let preparationTimeInMinutes numberOfLayers = numberOfLayers * 2

let elapsedTimeInMinutes numberOfLayers currentMinutesInOven =
    currentMinutesInOven + preparationTimeInMinutes numberOfLayers
