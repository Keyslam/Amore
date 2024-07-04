local PATH = string.sub(..., 1, string.len(...) - string.len("core.collector"))

---@module "amore.lib.class"
local Class = require(PATH .. "lib.class")

---@class Amore.Collector
---@operator call:Amore.Collector
local Collector = Class()

function Collector:constructor()
	self.rootCollection = self:createCollection("")
	self.activeCollectionStack = {}
end

---@param collectionName string
function Collector:pushCollection(collectionName)
	local activeCollection = self:getActiveCollection()
	local collection = self:createCollection(collectionName)

	table.insert(activeCollection.collections, collection)
	table.insert(self.activeCollectionStack, collection)
end

function Collector:popCollection()
	self.activeCollectionStack[#self.activeCollectionStack] = nil
end

---@param test Amore.Test
function Collector:pushTest(test)
	local activeCollection = self:getActiveCollection()
	table.insert(activeCollection.tests, test)
end

---@nodiscard
---@return Amore.Collection
function Collector:getRootCollection()
	return self.rootCollection
end

---@private
---@nodiscard
---@return Amore.Collection
function Collector:getActiveCollection()
	return self.activeCollectionStack[#self.activeCollectionStack] or self.rootCollection
end

---@private
---@nodiscard
---@param collectionName string
---@return Amore.Collection
function Collector:createCollection(collectionName)
	--TODO: Promote Amore.Collection to a class

	--- @type Amore.Collection
	local collection = {
		name = collectionName,
		tests = {},
		collections = {}
	}
	return collection
end

return Collector
