--[[
	Package link auto-generated by Rotriever
]]
local PackageIndex = script.Parent.Parent.Parent._Index

local Package = require(PackageIndex["EventPropagation"]["EventPropagation"])

export type EventPhase = Package.EventPhase
export type Event<T> = Package.Event<T> 
export type EventHandler<T> = Package.EventHandler<T> 
export type EventHandlerMap<T> = Package.EventHandlerMap<T> 
export type EventPropagationService<T> = Package.EventPropagationService<T> 


return Package
