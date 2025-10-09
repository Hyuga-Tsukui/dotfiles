return {
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
            usePlaceholders = true,
            completeUnimported = true,
            matcher = "fuzzy",
            codelenses = {
                gc_details = true,
                generate = true,
                tidy = true,
                upgrade_dependency = true,
            },
            semanticTokens = true,
        },
    },
}
