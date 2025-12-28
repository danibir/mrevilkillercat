if global.time = 0
{
	timestopped = true
	var assets = tag_get_assets("disabledOnTimestop")
	for (var i = 0; i < array_length(assets); i++)
	{
		var asset = assets[i]
		asset = asset_get_index(asset)
		with asset
		{
			array_push(other.timestopped_array, self)
			instance_deactivate_object(self)
		}
	}
}
if global.time != 0 and timestopped = true
{
	for (var i = 0; i < array_length(timestopped_array); i++)
	{
		var asset = timestopped_array[i]
		instance_activate_object(asset)
	}
	timestopped_array = []
}
if global.debug = true
{
	var assets = tag_get_assets("debugVis")
	for (var i = 0; i < array_length(assets); i++)
	{
		var asset = assets[i]
		asset = asset_get_index(asset)
		with asset
		{
			visible = true
		}
	}
}
else
{
	var assets = tag_get_assets("debugVis")
	for (var i = 0; i < array_length(assets); i++)
	{
		var asset = assets[i]
		asset = asset_get_index(asset)
		with asset
		{
			visible = false
		}
	}
}