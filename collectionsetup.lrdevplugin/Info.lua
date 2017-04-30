--[[----------------------------------------------------------------------------

ADOBE SYSTEMS INCORPORATED
 Copyright 2007 Adobe Systems Incorporated
 All Rights Reserved.

NOTICE: Adobe permits you to use, modify, and distribute this file in accordance
with the terms of the Adobe license agreement accompanying it. If you have received
this file from a source other than Adobe, then your use, modification, or distribution
of it requires the prior written permission of Adobe.

--------------------------------------------------------------------------------

Info.lua
Summary information for Hello World sample plug-in.

Adds menu items to Lightroom.

------------------------------------------------------------------------------]]

return {
    LrPluginName          = "Collection Setup",
    LrToolkitIdentifier   = 'com.codeside.collectionsetup',

    LrSdkVersion         = 6.0,
    LrSdkMinimumVersion  = 6.0,

    LrLibraryMenuItems =
    {
      {
        title = "Create Collection Sets...",
        file = "CreateTask.lua",
      },
    },

    VERSION = { major=1, minor=0, revision=0, build=1, },
    VSTRING = '1.0.0.0',

	LrInitPlugin = 'LRInit.lua'
}
