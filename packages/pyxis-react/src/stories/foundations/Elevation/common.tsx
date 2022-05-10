import Elevation from './Elevation';
import elevationColorTokens from '@primauk/tokens/json/elevation/colors.json';
import elevationSizeTokens from '@primauk/tokens/json/elevation/sizes.json';

export const generateTestComponentMeta: GenerateAllStoriesComponentMeta<typeof Elevation> = () => ({
  title: 'Test/Elevation',
  component: Elevation,
});

const sizes:ElevationSize[] = Object.keys(elevationSizeTokens) as ElevationSize[];

const colors:ElevationColor[] = Object.keys(elevationColorTokens)
  .sort((a, b) => {
      if (Number(b.slice(-2)) > Number(a.slice(-2))) return 1;
      if (Number(b.slice(-2)) < Number(a.slice(-2))) return -1;
      if (a > b) return 1;
      return -1;
  }) as ElevationColor[];

export const elevations: ElevationRow = {
  sizes,
  colors,
};

export interface ElevationRow {
  sizes: ElevationSize[];
  colors: ElevationColor[];
}

