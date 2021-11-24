import Color, { BackgroundColor } from './Color';
import styles from './Color.module.scss';

export const generateTestComponentMeta: GenerateAllStoriesComponentMeta<typeof Color> = () => ({
  title: 'Test/Colors',
  component: Color,
});

export interface ColorRow {
  name: string,
  value: string;
  type: BackgroundColor;
}

// TODO: to be replaced with design tokens
export const colors: ColorRow[] = Object.entries(styles)
  .filter(([key]) => key.startsWith('colorMap-') || key.startsWith('gradientMap-'))
  .map(([key, value]) => ({
    name: key.replace(/(colorMap-)|(gradientMap-)/g, ''),
    value,
    type: key.startsWith('colorMap-') ? 'solid' : 'gradient',
  }));
