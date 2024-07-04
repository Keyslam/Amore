local PATH = string.sub(..., 1, string.len(...) - string.len("core.runner"))

local Class = require(PATH .. ".lib.class")

---@class Amore.Runner
---@field rootCollection Amore.Collection
---@field reporter Amore.Reporter
---@operator call:Amore.Runner
local Runner = Class()

---@param rootCollection Amore.Collection
---@param reporter Amore.Reporter
function Runner:constructor(rootCollection, reporter)
	self.rootCollection = rootCollection
	self.reporter = reporter
end

---@return boolean wasSuccess
function Runner:run()
	self.reporter:onRunStarted(self.rootCollection)
	local wasSuccess = self:runCollection(self.rootCollection)
	self.reporter:onRunCompleted(self.rootCollection, false)

	return wasSuccess
end

---@param collection Amore.Collection
---@return boolean wasSuccess
function Runner:runCollection(collection)
	self.reporter:onCollectionStarted(collection)

	for _, test in ipairs(collection.tests) do
		local wasSuccess = self:runTest(test)
	end

	for _, subCollection in ipairs(collection.collections) do
		local wasSuccess = self:runCollection(subCollection)
	end

	self.reporter:onCollectionCompleted(collection, false)

	return true
end

---@param test Amore.Test
function Runner:runTest(test)
	self.reporter:onTestStarted(test)

	local wasSuccess, err = xpcall(function()
		test.body()
	end, function(err)
		return err
	end)

	self.reporter:onTestCompleted(test, false)

	return wasSuccess
end

return Runner
