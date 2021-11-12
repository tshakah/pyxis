import Elevation, { ElevationColor, ElevationSize } from './Elevation';

export const elevationSizes: ElevationSize[] = ['s', 'm', 'l'];
export const elevationColors: ElevationColor[] = [
  'action-40', 'brand-40', 'neutral-40', 'action-15', 'brand-15', 'neutral-15',
];

export const generateTestComponentMeta: GenerateAllStoriesComponentMeta<typeof Elevation> = () => ({
  title: 'Test/Elevation',
  component: Elevation,
});
