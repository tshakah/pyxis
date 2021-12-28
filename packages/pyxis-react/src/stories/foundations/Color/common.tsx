import { Color as ColorShape } from './Color';
import colorTokens from '@pyxis/tokens/json/colors.json';
import gradientTokens from '@pyxis/tokens/json/gradients.json';

export const generateTestComponentMeta: GenerateAllStoriesComponentMeta<typeof ColorShape> = () => ({
  title: 'Test/Colors',
  component: ColorShape,
});

export const colors:ColorRow[] = Object.entries(colorTokens).flatMap(([name, value]) => ({
  name: name as Color,
  value,
  type: "solid"
}));

export const gradients:ColorRow[] = Object.entries(gradientTokens).flatMap(([name, value]) => ({
  name: name as Gradient,
  value,
  type: "gradient"
}));

export interface ColorRow {
  name: Color | Gradient,
  value: string,
  type: ColorRowBackgroundType;
}

export type ColorRowBackgroundType = "solid" | "gradient";

