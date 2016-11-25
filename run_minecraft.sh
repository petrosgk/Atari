#!/bin/bash

th main.lua -env Minecraft -modelBody models.Minecraft -mode eval -height 84 -width 84 -zoom 4 -valSteps 100 -hiddenSize 256 -recurrent true -histLen 20 -bootstraps 0 -memSampleFreq 400 -memNSamples 100 -memSize 5e4 -learnStart 5e3 -epsilonSteps 5e4 -eta 0.00025 -tau 1000 -rewardClip 0 -tdClip 0 -gradClip 0 -noValidation true -verbose true -progFreq 1e3 -reportWeights true -cudnn true
