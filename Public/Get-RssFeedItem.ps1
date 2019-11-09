function Get-RssFeedItem
{
    param
    (
        [Parameter(Mandatory)]
        [string]$Uri,

        [switch]$OnlyNewGuids,
        [switch]$StoreGuids
    )

    Invoke-WebRequest -Uri $Uri `
    | Select-Object -ExpandProperty Content `
    | Select-Xml -XPath '//item' `
    | Select-Object -ExpandProperty Node `
    | ForEach-Object {
        [pscustomobject]@{
            Title       = $_.Title
            Description = $_.Description
            Link        = $_.Link
            Guid        = $_.Guid.InnerXml
            PubDateText = $_.PubDate
            PubDate     = [DateTime]::ParseExact($_.PubDate, 'ddd, d MMM yyyy HH:mm:ss zzz', $null)
            PSTypeName  = 'UncommonSense.Rss.FeedItem'
        }
    }
}