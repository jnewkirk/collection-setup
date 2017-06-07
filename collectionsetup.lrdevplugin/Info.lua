
return {
    LrPluginName          = "Collection Setup",
    LrPluginInfoUrl       = "http://github.com/jnewkirk/collection-setup",
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

    VERSION = { major=1, minor=1, revision=0, build=1, },
    VSTRING = '1.1.0.1',

    LrInitPlugin = 'LRInit.lua'
}
