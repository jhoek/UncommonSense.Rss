function ConvertTo-Rfc822DateTime
{
    param
    (
        [Parameter(Mandatory)]
        [DateTime]$DateTime
    )

    @(
        $DateTime.ToString('ddd, d MMM yyyy HH:mm:ss')
        ($DateTime.ToString('zzz') -replace ':', '')
    ) -join ' '
}