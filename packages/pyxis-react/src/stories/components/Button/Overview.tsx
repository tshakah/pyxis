import React, { FC, SFC } from "react";
import { Canvas, Story } from "@storybook/addon-docs";
import OverviewTemplate from "stories/utils/OverviewTemplate";
import Button from "../../../components/Button";

const overviewDescription = (
  <>
    <p>
      Buttons allow the user to perform actions and make decisions with a single tap or click.
    </p>
    <p>
      🚧 Soon on your screens 🚧
    </p>
  </>
)
const Overview: FC = () => (
  <>
    <OverviewTemplate title="Button" description={overviewDescription} category="Component" isMain>
      <Canvas>
        <Story id="components-button-all-stories--primary" />
      </Canvas>
    </OverviewTemplate>
  </>
)

export default Overview;