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
