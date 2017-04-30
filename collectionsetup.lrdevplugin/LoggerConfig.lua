local LrLogger = import "LrLogger"
local logger = LrLogger( 'CollectionSetup' )

logger:enable(
	{
		['debug'] = 'logfile',
		['trace'] = 'logfile',
		['info'] = 'logfile',
		['warn'] = 'logfile',
		['error'] = 'logfile',
		['fatal'] = 'logfile'
	}
)
