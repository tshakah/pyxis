import React, { FC } from 'react';
import OverviewTemplate from 'stories/components/OverviewTemplate';
import { elevationColors, elevationSizes } from './common';
import Elevation, { ElevationColor } from './Elevation';
import styles from './Elevation.module.scss';

const opacity15 = elevationColors.filter((c) => c.endsWith('15'));
const opacity40 = elevationColors.filter((c) => c.endsWith('40'));

const description = (
  <>
    <p>
      Elevation is the relative distance between two surfaces along the z-axis.
      It&apos;s a way of thinking that&apos;s less about the actual aesthetic and more about creating an
      experience that feels like it was designed by Google. Material Design is where shadows were
      born: a simple concept to effectively represent elevation on the screen.
    </p>
    <p>We apply this concept to Pyxis as well.</p>
    <p>
      Components normally rest over your screen (a surface), but that component can go up or down over
      that surface, that is what we call Z-index. As an example a button can live resting on your
      screen (surface) but when that button goes hover, the component suffers an elevation and a
      shadow will appear beneath the button.
    </p>
    <p>
      We are trying to fix some points at the Z-index level where components can live. By default we
      have three levels of elevation between layers or between the components themselves with respect
      to the base. The elevation level of each layer is indicated by its shadow.
    </p>
  </>
);

const Column: FC<ColumnProps> = ({ title, colors }) => (
  <div>
    <h2 className="title-m--bold spacing-v-m">
      {title}
    </h2>
    {colors.map(
      (color) => (
        <div key={color} className="spacing-v-l">
          <div className={styles.grid}>
            {elevationSizes.map(
              (size) => <Elevation key={color + size} size={size} color={color} />,
            )}
          </div>
        </div>
      ),
    )}
  </div>
);

const Overview: FC = () => (
  <OverviewTemplate title="Elevation" description={description} category="Foundation">
    <div className={styles.wrapper}>
      <Column title="Opacity 40" colors={opacity40} />
      <Column title="Opacity 15" colors={opacity15} />
    </div>
  </OverviewTemplate>
);

interface ColumnProps {
  title: string,
  colors: ElevationColor[]
}

export default React.memo(Overview);
