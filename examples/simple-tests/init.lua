local Amore = require("amore")

local collector = Amore.collector()
local descriptors = Amore.descriptors(collector)

local Collection = function(...) descriptors:collection(...) end
local Describe = function(...) descriptors:describe(...) end

local function sum(a, b) return a + b end
local function subtract(a, b) return a / b end
local function multiply(a, b) return a * b end
local function divide(a, b) return a / b end

descriptors:describe("my-test", function()
end)

Collection("arithmetic-tests", function()
	Describe("addition-test", function()
		local result = sum(3, 4)
		error("ohnoo")
		-- Assert:isEqual(7, result)
	end)

	Describe("subtraction-test", function()
		local result = subtract(10, 4)
		-- Assert:isEqual(6, result)
	end)

	Describe("multiplication-test", function()
		local result = multiply(3, 5)
		-- Assert:isEqual(15, result)
	end)

	Describe("division-test", function()
		local result, err = divide(10, 2)
		-- Assert:isEqual(5, result)
		-- Assert:isNil(err)
	end)

	Describe("division-by-zero-test", function()
		local result, err = divide(10, 0)
		-- Assert:isNil(result)
		-- Assert:isEqual("division by zero", err)
	end)
end)

local rootCollection = collector:getRootCollection()
local reporter = Amore.reporters.consoleReporter()

local runner = Amore.runner(rootCollection, reporter)
local wasSuccess = runner:run()

love.event.quit(wasSuccess and 0 or 1)
