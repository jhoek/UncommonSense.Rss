function Get-RssFeed
{
    param
    (
        [Parameter(Mandatory)]
        [string]$Uri
    )

    Invoke-WebRequest -Uri $Uri `
    | Select-Object -ExpandProperty Content `
    | ForEach-Object { [xml]$_ } `
    | Select-Object -ExpandProperty rss `
    | Select-Object -ExpandProperty channel `
    | ForEach-Object {
        [PSCustomObject]@{
            Title       = $_.Title
            Description = $_.Description
            Link        = $_.Link
            PSTypeName  = 'UncommonSense.Rss.Feed'
        }
    }
}