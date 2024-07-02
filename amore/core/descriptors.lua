local PATH = string.sub(..., 1, string.len(...) - string.len("core.descriptors"))

---@module "amore.lib.class"
local Class = require(PATH.."lib.class")

---@class Amore.Descriptors
---@field collector Amore.Collector
---@operator call:Amore.Descriptors
local Descriptors = Class()

---@param collector Amore.Collector
function Descriptors:constructor(collector)
	self.collector = collector
end

---@param testName string
---@param testBody fun()
function Descriptors:describe(testName, testBody)
	--TODO: Promote Amore.Test to a class

	---@type Amore.Test
	local test = {
		name = testName,
		body = testBody
	}

	self.collector:pushTest(test)
end

---@param collectionName string
---@param collectionBody fun()
function Descriptors:collection(collectionName, collectionBody)
	self.collector:pushCollection(collectionName)
	collectionBody()
	self.collector:popCollection()
end

return Descriptors
