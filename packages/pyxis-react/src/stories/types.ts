import { ComponentMeta } from '@storybook/react';
import { JSXElementConstructor } from 'react';

declare global {
  type GeneratePropertiesComponentMeta<componentTypeOf extends JSXElementConstructor<any>> =
    (storyName?: string) => ComponentMeta<componentTypeOf>;

  type GenerateAllStoriesComponentMeta<componentTypeOf extends JSXElementConstructor<any>> =
    (storyName?: string) => ComponentMeta<componentTypeOf>;

  type GenerateAllStories<staticProps> =
    (module: NodeModule, storyName: string, staticComponentData: staticProps) => void;
}
