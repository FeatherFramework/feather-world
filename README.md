# Feather World

Focused world-runtime resource for Feather Framework. It owns population density, map and interior compatibility fixes, buggy ambient-wagon cleanup, random-loot prompt suppression, and named map helpers.

Start it after `feather-core`. Core does not depend on this resource and remains operational when World is stopped.

## Tests

- Server console: `WorldContractSmokeTest`
- Client F8 after the five-second interior initialization: `WorldClientSmokeTest`

Stopping the resource should stop density enforcement, wagon cleanup, and loot-prompt suppression without affecting Core readiness.

## Wagon cleanup

`Config.WagonFix` controls detection frequency, network-control retries, cleanup distances, and the allowlist of wagon component models. Cleanup only targets stopped ambient wagons whose harness horse is still walking. Mission entities and wagons occupied by a player are excluded, and nearby objects are removed only when attached to the wagon or explicitly listed as a known wagon component.
