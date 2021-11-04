import React, { FC } from 'react';
import { Canvas, Story } from '@storybook/addon-docs';
import { capitalize } from 'utils';

const DocStoryGenerator: FC<DocsProps> = ({ storyPath, storyNameList }) => (
  <>
    {storyNameList.map((storyName) => (
      <>
        <h2>{storyName.split('-').map((s) => capitalize(s)).join(' ')}</h2>
        <Canvas>
          <Story id={`${storyPath}--${storyName}`} />
        </Canvas>
      </>
    ))}
  </>
);

export default DocStoryGenerator;

interface DocsProps {
  storyPath: string,
  storyNameList: string[]
}
