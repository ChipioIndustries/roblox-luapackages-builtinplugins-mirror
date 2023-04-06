game:DefineFastFlag("UGCValidateHandleSize", false)
game:DefineFastFlag("UGCExtraBannedNames", false)
game:DefineFastFlag("UGCValidateMeshVertColors", false)
game:DefineFastString("UGCLCAllowedAssetTypeIds", "")
game:DefineFastFlag("UGCValidateHSR", false)
game:DefineFastFlag("UGCFixModerationCheck", false)
game:DefineFastFlag("UGCBetterModerationErrorText", false)
game:DefineFastFlag("UGCLCQualityValidation", false)
game:DefineFastFlag("UGCLCQualityReplaceLua", false)
game:DefineFastFlag("UGCReturnAllValidations", false)

local root = script

local validateMeshPartAccessory = require(root.validation.validateMeshPartAccessory)

local isLayeredClothing = require(root.util.isLayeredClothing)
local validateLayeredClothingAccessory = require(root.validation.validateLayeredClothingAccessory)
local validateLegacyAccessory = require(root.validation.validateLegacyAccessory)
local validateLayeredClothingAccessoryMeshPartAssetFormat = require(root.validation.validateLayeredClothingAccessoryMeshPartAssetFormat)
local validateLegacyAccessoryMeshPartAssetFormat = require(root.validation.validateLegacyAccessoryMeshPartAssetFormat)

local function validateInternal(isAsync, instances, assetTypeEnum, isServer): (boolean, {string}?)
	if isLayeredClothing(instances[1]) then
		return validateLayeredClothingAccessory(instances, assetTypeEnum, isServer)
	else
		return validateLegacyAccessory(instances, assetTypeEnum, isServer)
	end
end

local UGCValidation = {}

function UGCValidation.validate(instances, assetTypeEnum, isServer)
	local success, reasons = validateInternal(--[[ isAsync = ]] false, instances, assetTypeEnum, isServer)
	return success, reasons
end

function UGCValidation.validateAsync(instances, assetTypeEnum, callback, isServer)
	coroutine.wrap(function()
		callback(validateInternal(--[[ isAsync = ]] true, instances, assetTypeEnum, isServer))
	end)()
end

function UGCValidation.validateMeshPartAssetFormat2(instances, specialMeshAccessory, assetTypeEnum, isServer)
	if isLayeredClothing(instances[1]) then
		return validateLayeredClothingAccessoryMeshPartAssetFormat(instances, specialMeshAccessory, assetTypeEnum, isServer)
	else
		return validateLegacyAccessoryMeshPartAssetFormat(instances, specialMeshAccessory, assetTypeEnum, isServer)
	end
end

-- assumes specialMeshAccessory has already passed through UGCValidation.validate()
function UGCValidation.validateMeshPartAssetFormat(specialMeshAccessory, meshPartAccessory, assetTypeEnum, isServer)
	-- layered clothing assets should be the same binary for source and avatar_meshpart_accesory
	if specialMeshAccessory and isLayeredClothing(specialMeshAccessory) then
		return UGCValidation.validate({ specialMeshAccessory }, assetTypeEnum, isServer)
	end

	local success, reasons

	success, reasons = validateMeshPartAccessory(specialMeshAccessory, meshPartAccessory)
	if not success then
		return false, reasons
	end

	return true
end

return UGCValidation
