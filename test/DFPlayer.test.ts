import { expect } from 'chai';
import { fixtureLoader, makeInitArgs, makeRevealArgs, ZERO_ADDRESS } from './utils/TestUtils';
import { defaultWorldFixture, World } from './utils/TestWorld';
import {
  ADMIN_PLANET,
  ADMIN_PLANET_CLOAKED,
  INVALID_PLANET,
  INVALID_TOO_CLOSE_SPAWN,
  INVALID_TOO_FAR_SPAWN,
  LVL0_PLANET_DEEP_SPACE,
  LVL0_PLANET_OUT_OF_BOUNDS,
  LVL1_PLANET_NEBULA,
  SPAWN_PLANET_1,
  SPAWN_PLANET_2,
} from './utils/WorldConstants';

describe.only('DarkForestPlayer', function () {
  let world: World;

  beforeEach('load fixture', async function () {
    world = await fixtureLoader(defaultWorldFixture);
  });

  it('initializes df player successfully with the correct planet value', async function () {
    await expect(world.user1CorePlayer.initializePlayer(...makeInitArgs(SPAWN_PLANET_1)))
      .to.emit(world.contracts.core, 'PlayerInitialized')
      .withArgs(world.contracts.player.address, SPAWN_PLANET_1.id.toString());

    const planetData = await world.contracts.core.planets(SPAWN_PLANET_1.id);

    await expect((await world.contracts.core.players(world.contracts.player.address)).isInitialized).equal(
      true
    );
    expect(planetData.owner).to.equal(world.contracts.player.address);
    expect(planetData.population).to.be.equal('50000');
    expect(planetData.populationCap).to.be.equal('100000');
    expect(planetData.planetType).to.be.equal(0); // regular planet
    expect(planetData.isHomePlanet).to.be.equal(true);
  });
});
