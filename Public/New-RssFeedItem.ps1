# Consider adding these item-level elements later:
# - author
# - category
# - comments
# - enclosure
# - source

function New-RssFeedItem
{
    param
    (
        [Parameter(Mandatory)]
        [string]$Title,

        [string]$Description,

        [string]$ID,

        [string]$Link,

        [Nullable[DateTime]]$PubDate
    )

    $Item = [RssItem]::new($Title)
    $Item.Description = $Description
    $Item.ID = $ID
    $Item.Link = $Link
    $Item.PubDate = $PubDate

    $Item
}