# Certificate LevelI: Beginners' robot

This template robot:

- Uses [Robot Framework](https://robocorp.com/docs/languages-and-frameworks/robot-framework/basics) syntax.
- Includes all the necessary dependencies and initialization commands (`conda.yaml`).
- Robot illbe developed with (`tasks.robot`) file.

## Learning materials

- [All docs related to Robot Framework](https://robocorp.com/docs/languages-and-frameworks/robot-framework)

## Use of Vault for secrets

- Setting the robot up to run locally we need to create a (`vault.json`) file.
- The vault needs to be placedoutside the repository (for example, /Users/<your-username>/vault.json). Never commit the vault file.
- Provide the vault values in the (`vault.json`) file, for exampe:
    ```json
    {
      "credentials": {
        "username": "some-username",
        "password": "some-passord"
      }
    }
    ```
 - Windows: Escape file paths like: "C:\\Users\\<your-username-here>\\vault.json"
