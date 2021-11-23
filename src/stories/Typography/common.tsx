import Typography, { Size, Type, Weight } from './Typography';

export const generateTestComponentMeta: GenerateAllStoriesComponentMeta<typeof Typography> = () => ({
  title: 'Test/Typography',
  component: Typography,
});

export interface PyxisTypography {
  type: Type
  sizes: Size[],
  weights: Weight[];
}

export const pyxisTitle: PyxisTypography = {
  type: 'title',
  sizes: ['xl', 'l', 'm', 's'],
  weights: ['bold', 'book'],
};

export const pyxisText: PyxisTypography = {
  type: 'text',
  sizes: ['l', 'm', 's'],
  weights: ['bold', 'book', 'light'],
};
