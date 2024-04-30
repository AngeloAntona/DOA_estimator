classdef AudioData
    properties
        Data
        SampleRate
    end
    
    methods
        function obj = AudioData(filepath)
            % Constructor for AudioData that loads audio from the specified filepath
            [obj.Data, obj.SampleRate] = audioread(filepath);
        end
        
        function obj = normalize(obj)
            % Method to normalize audio data
            obj.Data = obj.Data / max(abs(obj.Data), [], 'all');
        end
        
        % Other preprocessing methods can be added here as needed
    end
end