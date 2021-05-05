function Add-SinkMSSqlServer {
	<#
	.SYNOPSIS
		Writes log events into table in MSSqlServer db.
	.DESCRIPTION
		Adds a sink that writes log events to a table in a MSSqlServer database.
		Create a database and execute the table creation script found here https://gist.github.com/mivano/10429656 or use the AutoCreateSqlTable option.
	.PARAMETER LoggerConfig
		Instance of LoggerConfiguration
	.PARAMETER ConnectionString
		The connection string to the database where to store the events.
	.Parameter TableName
		Name of the database table for writing the log events. (default: LogEvents)
	.Parameter SchemaName
		Name of the database schema (default: "dbo")
	.Parameter AutoCreateSqlTable
		Flag to automatically create the log events table if it does not exist (default: false)
	.Parameter BatchPostingLimit
		Limits how many log events are written to the database per batch (default: 50)
	.Parameter BatchPeriod
		Time span until a batch of log events is written to the database (default: 5 seconds)
	.Parameter EagerlyEmitFirstEvent
		Flag to eagerly emit a batch containing the first received event (default: true)
	.Parameter UseAzureManagedIdentity
		Flag to enable SQL authentication using Azure Managed Identities (default: false)
	.Parameter AzureServiceTokenProviderResource
		Azure service token provider to be used for Azure Managed Identities
	.PARAMETER RestrictedToMinimumLevel
		The minimum level for events passed through the sink. Ignored when LevelSwitch is specified.
	.PARAMETER Formatter
		A formatter, such as JsonFormatter(See Get-JsonFormatter), to convert the log events into text for the file. If control of regular text formatting is required, use Default parameter set.
	.PARAMETER FormatProvider
		Supplies culture-specific formatting information, or null.
	.INPUTS
		Instance of LoggerConfiguration
	.OUTPUTS
		LoggerConfiguration object allowing method chaining
	.EXAMPLE
		PS> New-Logger | Add-SinkMSSqlServer TODO FILL_HERE | Start-Logger
	#>

	[OutputType([Serilog.LoggerConfiguration])]
	[Cmdletbinding()]
	param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[Serilog.LoggerConfiguration]$LoggerConfig,

		[Parameter(Mandatory = $true)]
		[Alias('cnn')]
		[string]$ConnectionString,

		[Parameter(Mandatory = $false)]
		[string]$TableName = 'LogEvents',

		[Parameter(Mandatory = $false)]
		[string]$SchemaName = 'dbo',

		[Parameter(Mandatory = $false)]
		[switch]$AutoCreateSqlTable,

		[Parameter(Mandatory = $false)]
		[int]$BatchPostingLimit = 50,

		[Parameter(Mandatory = $false)]
		[System.TimeSpan]$BatchPeriod = [System.TimeSpan]::FromSeconds(5),

		[Parameter(Mandatory = $false)]
		[bool]$UseAzureManagedIdentity = $false,

		[Parameter(Mandatory = $false)]
		[string]$AzureServiceTokenProviderResource,

		[Parameter(Mandatory = $false)]
		[Serilog.Events.LogEventLevel]$RestrictedToMinimumLevel = [Serilog.Events.LogEventLevel]::Verbose,

		[Parameter(Mandatory = $false)]
		[Serilog.Formatting.ITextFormatter]$Formatter = $null,

		[Parameter(Mandatory = $false)]
		[System.IFormatProvider]$FormatProvider = $null
	)

	if (Test-PsCore) {
		$sinkOptions = [Serilog.Sinks.MSSqlServer.Sinks.MSSqlServer.Options.SinkOptions]::new()
		$sinkOptions.TableName = $TableName
		$sinkOptions.SchemaName = $SchemaName
		$sinkOptions.AutoCreateSqlTable = $AutoCreateSqlTable
		$sinkOptions.BatchPostingLimit = $BatchPostingLimit
		$sinkOptions.BatchPeriod = $BatchPeriod
		$sinkOptions.UseAzureManagedIdentity = $UseAzureManagedIdentity
		$sinkOptions.AzureServiceTokenProviderResource = $AzureServiceTokenProviderResource
	
		$LoggerConfig = [Serilog.LoggerConfigurationMSSqlServerExtensions]::MSSqlServer([Serilog.Configuration.LoggerSinkConfiguration]$LoggerConfig.WriteTo, 
			[string]$ConnectionString, 
			[Serilog.Sinks.MSSqlServer.Sinks.MSSqlServer.Options.SinkOptions]$sinkOptions,
			[Microsoft.Extensions.Configuration.IConfiguration]$null, # TODO implement
			[Serilog.Events.LogEventLevel]$RestrictedToMinimumLevel,
			[System.IFormatProvider]$FormatProvider,
			[Serilog.Sinks.MSSqlServer.ColumnOptions]$null, # TODO implement
			[Microsoft.Extensions.Configuration.IConfigurationSection]$null, # TODO implement
			[Serilog.Formatting.ITextFormatter]$Formatter,
			[Microsoft.Extensions.Configuration.IConfigurationSection]$null # TODO implement
		)
	}
	else {
		$sinkOptions = [Serilog.Sinks.MSSqlServer.MSSqlServerSinkOptions]::new()
		$sinkOptions.TableName = $TableName
		$sinkOptions.SchemaName = $SchemaName
		$sinkOptions.AutoCreateSqlTable = $AutoCreateSqlTable
		$sinkOptions.BatchPostingLimit = $BatchPostingLimit
		$sinkOptions.BatchPeriod = $BatchPeriod
		$sinkOptions.UseAzureManagedIdentity = $UseAzureManagedIdentity
		$sinkOptions.AzureServiceTokenProviderResource = $AzureServiceTokenProviderResource

		$LoggerConfig = [Serilog.LoggerConfigurationMSSqlServerExtensions]::MSSqlServer([Serilog.Configuration.LoggerSinkConfiguration]$LoggerConfig.WriteTo, 
			[string]$ConnectionString, 
			$sinkOptions,
			[Microsoft.Extensions.Configuration.IConfiguration]$null, # TODO implement
			[Microsoft.Extensions.Configuration.IConfigurationSection]$null, # TODO implement
			[Serilog.Events.LogEventLevel]$RestrictedToMinimumLevel,
			[System.IFormatProvider]$FormatProvider,
			[Serilog.Sinks.MSSqlServer.ColumnOptions]$null, # TODO implement
			[Microsoft.Extensions.Configuration.IConfigurationSection]$null, # TODO implement
			[Serilog.Formatting.ITextFormatter]$Formatter
		)
	}

	$LoggerConfig
}
