# Feather World

Focused world-runtime resource for Feather Framework. It owns population density, map and interior compatibility fixes, buggy ambient-wagon cleanup, random-loot prompt suppression, and named map helpers.

Start it after `feather-core`. Core does not depend on this resource and remains operational when World is stopped.

## Tests

- Server console: `WorldContractSmokeTest`
- Client F8 after the five-second interior initialization: `WorldClientSmokeTest`

Stopping the resource should stop density enforcement, wagon cleanup, and loot-prompt suppression without affecting Core readiness.

## Interiors and IMAPs

Feather World owns the production interior and IMAP activation lifecycle. Its declarative selection data was reviewed against the current [`redm-ipls`](https://github.com/outsider31000/redm-ipls) resource used by the VORP recipe, while the implementation, lifecycle state, diagnostics, and contract tests are Feather-native. Verified IMAP descriptions are stored alongside their hashes; speculative or unclear reference notes are intentionally omitted. Each selected interior also records its coordinates, type hash, internal type name, and RPF name using the `rdr3_discoveries` catalogs as reference data. `Config.InteriorFix` controls activation and records the expected catalog counts used to detect incomplete deployments.

Curated interior definitions and entity sets are organized in `client/interiors/definitions.lua`. Deterministic IMAP states are kept separately in `client/interiors/imaps.lua`; runtime activation and diagnostics remain in `client/services/interiorsfix.lua`.

When `Config.DevMode` is enabled, client F8 command `WorldInteriorInspect <interiorId>` prints the metadata and validity of a selected interior. It is not registered in production mode.

## Wagon cleanup

`Config.WagonFix` controls detection frequency, network-control retries, cleanup distances, and the allowlist of wagon component models. Cleanup only targets stopped ambient wagons whose harness horse is still walking. Mission entities and wagons occupied by a player are excluded, and nearby objects are removed only when attached to the wagon or explicitly listed as a known wagon component.
