# Responsibility-centric design + Immutability

Things to note:

- Rails is treated like a dependency. The business logic is separated in lib,
  including domain entities, which are implemented without ActiveRecord.
- Persistence has a clear boundary outside the business domain. The domain is
  persistence agnostic.
- Domain entities are immutable. Each change results in new object with
  modified attribute. The original object is left intact.
- The domain is centered around responsibilities, not data. Interactions are
  implemented as services which can be decorated or swapped for other services
  compliant with the same contract.
