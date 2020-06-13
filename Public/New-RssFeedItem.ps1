function New-RssFeedItem
{
    [CmdletBinding(DefaultParameterSetName = 'Title')]
    param
    (
        [Parameter(Mandatory, ParameterSetName = 'Title')]
        [Parameter(ParameterSetName = 'Description')]
        [string]$Title,

        [Parameter(Mandatory, ParameterSetName = 'Description')]
        [Parameter(ParameterSetName = 'Title')]
        [string]$Description
    )

    [RssItem]::new($Title, $Description)
}