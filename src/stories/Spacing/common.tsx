import Spacing, { Size } from './Spacing';

export const generateTestComponentMeta: GenerateAllStoriesComponentMeta<typeof Spacing> = () => ({
  title: 'Test/Spacing',
  component: Spacing,
});

export interface SpacingRow {
  size: Size;
  baseValue: string;
  maxValue: string;
}

// TODO: to be replaced with design tokens
export const spacing:SpacingRow[] = [
  {
    size: 'xxxl',
    baseValue: '50px',
    maxValue: '120px',
  },
  {
    size: 'xxl',
    baseValue: '40px',
    maxValue: '80px',
  },
  {
    size: 'xl',
    baseValue: '35px',
    maxValue: '60px',
  },
  {
    size: 'l',
    baseValue: '30px',
    maxValue: '40px',
  },
  {
    size: 'm',
    baseValue: '25px',
    maxValue: '30px',
  },
  {
    size: 's',
    baseValue: '20px',
    maxValue: '20px',
  },
  {
    size: 'xs',
    baseValue: '15px',
    maxValue: '15px',
  },
  {
    size: 'xxs',
    baseValue: '10px',
    maxValue: '10px',
  },
  {
    size: 'xxxs',
    baseValue: '5px',
    maxValue: '5px',
  },
];
