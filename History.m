% This class uses a fixed-size cell array to maintain a history of data values (type agnostic, can be mixed types).

classdef History < handle
    properties  (Access = protected)
        Data     = {};
        Capacity = 0;
        Size     = 0;

        CurrentIndex = 0;
        LowerIndex   = 0;
        UpperIndex   = 0;
    end

    methods
        function Object = History(capacity)
            if (nargin == 0)
                capacity = 50; % Default history size.
            end

            Object.Capacity = capacity;
            Object.Data     = cell(capacity, 1);
        end

        function Object = Clear(Object, capacity)
            if (nargin == 1)
                Object = History(Object.Capacity); % Initialize a new object with the same capacity.
            else
                Object = History(capacity); % Use the specified capacity.
            end
        end

        function Object = Update(Object, dataValue)
            previousIndex = Object.CurrentIndex;
            currentIndex  = Object.CurrentIndex + 1;
            lowerIndex    = max(1, Object.LowerIndex);

            if (currentIndex > Object.Capacity)
                currentIndex = 1;
            end

            currentSize = Object.Size;
            upperIndex  = Object.UpperIndex;
            if (currentSize == Object.Capacity && upperIndex == previousIndex)
                lowerIndex = mod(lowerIndex, Object.Capacity) + 1;
            end

            upperIndex  = currentIndex; % Overwrite upperIndex with new limit.
            currentSize = mod(upperIndex - lowerIndex, Object.Capacity) + 1;

            Object.Data{currentIndex} = dataValue;
            Object.CurrentIndex       = currentIndex;
            Object.LowerIndex         = lowerIndex;
            Object.UpperIndex         = upperIndex;
            Object.Size               = currentSize;
        end

        function success = Back(Object)
            success = Object.Size > 1 && Object.CurrentIndex ~= Object.LowerIndex;
            if (success)
                Object.CurrentIndex = mod(Object.CurrentIndex - 2, Object.Capacity) + 1;
            end
        end

        function success = Forward(Object)
            success = Object.Size > 1 && Object.CurrentIndex ~= Object.UpperIndex;
            if (success)
                Object.CurrentIndex = mod(Object.CurrentIndex, Object.Capacity) + 1;
            end
        end

        function [success, dataValue] = GetPrevious(Object)
            success   = Object.Size > 1 && Object.CurrentIndex ~= Object.LowerIndex;
            dataValue = [];
            if (success)
                previousIndex = mod(Object.CurrentIndex - 2, Object.Capacity) + 1;
                dataValue     = Object.Data{previousIndex};
            end
        end

        function [success, dataValue] = GetNext(Object)
            success   = Object.Size > 1 && Object.UpperIndex ~= Object.CurrentIndex;
            dataValue = [];
            if (success)
                nextIndex = mod(Object.CurrentIndex, Object.Capacity) + 1;
                dataValue = Object.Data{nextIndex};
            end
        end

        function [success, dataValue] = GetCurrent(Object)
            success   = Object.Size > 0;
            dataValue = [];
            if (success)
                dataValue = Object.Data{Object.CurrentIndex};
            end
        end

        function capacity = GetCapacity(Object)
            capacity = Object.Capacity;
        end

        function historySize = GetSize(Object)
            historySize = Object.Size;
        end
    end
end