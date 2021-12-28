import Radius from './Radius';
import radiusTokens from '@pyxis/tokens/json/radius.json';

export const generateTestComponentMeta: GenerateAllStoriesComponentMeta<typeof Radius> = () => ({
  title: 'Test/Radius',
  component: Radius,
});

export const radius: RadiusRow[] = Object.entries(radiusTokens).flatMap(([size, value]) => ({
  size: size as RadiusSize,
  value,
}));

export const edges: EdgeRow[] = [
  {
    name: 'all',
    value: '$size',
  },
  {
    name: 'top',
    value: '$size $size 0 0',
  },
  {
    name: 'right',
    value: '0 $size $size 0',
  },
  {
    name: 'bottom',
    value: '0 0 $size $size',
  },
  {
    name: 'left',
    value: '$size 0 0 $size',
  },
];

export interface RadiusRow {
  size: RadiusSize;
  value: number;
}

export interface EdgeRow {
  name: RadiusEdge;
  value: string;
}
