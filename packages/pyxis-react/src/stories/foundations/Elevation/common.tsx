import Elevation, { Color, Size } from './Elevation';

export const generateTestComponentMeta: GenerateAllStoriesComponentMeta<typeof Elevation> = () => ({
  title: 'Test/Elevation',
  component: Elevation,
});

export interface ElevationRow {
  sizes: Size[];
  colors: Color[];
}

// TODO: to be replaced with design tokens
export const elevations: ElevationRow = {
  sizes: ['s', 'm', 'l'],
  colors: [
    'action40', 'brand40', 'neutral40', 'action15', 'brand15', 'neutral15',
  ],
};
