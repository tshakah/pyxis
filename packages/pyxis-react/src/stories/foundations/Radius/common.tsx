import Radius, { Size } from './Radius';

export const generateTestComponentMeta: GenerateAllStoriesComponentMeta<typeof Radius> = () => ({
  title: 'Test/Radius',
  component: Radius,
});

export interface RadiusRow {
  size: Size;
  value: string;
}

export interface EdgeRow {
  name: 'all' | 'right' | 'top' | 'left' | 'bottom' ;
  value: string;
}

// TODO: to be replaced with design tokens
export const radius: RadiusRow[] = [
  {
    size: 'xl',
    value: '25px',
  },
  {
    size: 'l',
    value: '20px',
  },
  {
    size: 'm',
    value: '15px',
  },
  {
    size: 's',
    value: '10px',
  },
  {
    size: 'xs',
    value: '5px',
  },
];

// TODO: to be replaced with design tokens
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
