import Color, { BackgroundColor } from './Color';
import styles from './Color.module.scss';

export const generateTestComponentMeta: GenerateAllStoriesComponentMeta<typeof Color> = () => ({
  title: 'Test/Colors',
  component: Color,
});

export interface PyxisColor {
  name: string,
  value: string;
  type: BackgroundColor;
}

export const pyxisColors: PyxisColor[] = Object.entries(styles)
  .filter(([key]) => key.startsWith('colorMap-') || key.startsWith('gradientMap-'))
  .map(([key, value]) => ({
    name: key.replace(/(colorMap-)|(gradientMap-)/g, ''),
    value,
    type: key.startsWith('colorMap-') ? 'solid' : 'gradient',
  }));
