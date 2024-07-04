local PATH = string.sub(..., 1, string.len(...) - string.len("core.reporters.reporter"))

local Class = require(PATH..".lib.class")

---@class Amore.Reporter
local Reporter = Class()

function Reporter:onRunStarted(rootCollection)
end

function Reporter:onRunCompleted(rootCollection, wasSuccess)
end

function Reporter:onCollectionStarted(collection)
end

function Reporter:onCollectionCompleted(collection, wasSuccess)
end

function Reporter:onTestStarted(test)
end

function Reporter:onTestCompleted(test, wasSuccess)
end

return Reporter
