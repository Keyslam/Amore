local PATH = string.sub(..., 1, string.len(...) - string.len("core.reporters.consoleReporter"))

local Class = require(PATH..".lib.class")

---@class Amore.ConsoleReporter : Amore.Reporter
---@operator call:Amore.ConsoleReporter
local ConsoleReporter = Class()

function ConsoleReporter:constructor()
	self.indents = 0
end

function ConsoleReporter:onRunStarted(rootCollection)
	self:print("Starting test run")
	self:indent()
end

function ConsoleReporter:onRunCompleted(rootCollection, wasSuccess)
	self:unindent()
end

function ConsoleReporter:onCollectionStarted(collection)
	self:print("[Collection] %s", collection.name)
	self:indent()
end

function ConsoleReporter:onCollectionCompleted(collection, wasSuccess)
	self:unindent()
end

function ConsoleReporter:onTestStarted(test)
end

function ConsoleReporter:onTestCompleted(test, wasSuccess)
	self:print("[Test] %s", test.name)
end

function ConsoleReporter:indent()
	self.indents = self.indents + 1
end

function ConsoleReporter:unindent()
	self.indents = self.indents - 1
end

function ConsoleReporter:print(s, ...)
	local str = ""
	for i = 1, self.indents do
		str = str .. "\t"
	end
	str = str .. string.format(s, ...)
	print(str)
end

return ConsoleReporter
