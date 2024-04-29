classdef ULAConfig
    properties
        MicrophoneCount
        ArrayLength % in meters
        SoundSpeed % in m/s
        SamplingFrequency % in Hz
    end
    
    methods
        function obj = ULAConfig(microphone_count, array_length_cm, sound_speed, sampling_frequency)
            % Constructor for ULAConfig
            obj.MicrophoneCount = microphone_count;
            obj.ArrayLength = array_length_cm / 100; % Convert cm to meters
            obj.SoundSpeed = sound_speed;
            obj.SamplingFrequency = sampling_frequency;
        end
    end
end
