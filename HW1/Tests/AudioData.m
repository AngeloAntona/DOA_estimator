classdef AudioData
    properties
        Data
        SampleRate
    end
    
    methods
        function obj = AudioData(filepath)
            % Constructor for AudioData that loads audio from the specified filepath
            if filepath ~= "" 
                [obj.Data, obj.SampleRate] = audioread(filepath);
            end
        end
        
        function obj = normalize(obj)
            % Method to normalize audio data
            obj.Data = obj.Data / max(abs(obj.Data), [], 'all');
        end        
    end
end
