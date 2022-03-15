import React from 'react';
import {ComponentMeta} from '@storybook/react';
import Form from "components/Form";
import {IconLock, IconPlate} from "components/Icon/Icons";

export default {
  title: 'Components/Form 🚧/React Test 🚧',
} as ComponentMeta<typeof Form>;

export const Default = () => (
  <Form className="form-grid form-grid--gap-large">
    <Form.Item hint="Hint message" id="one">
      <Form.Label>Plate Number</Form.Label>
      <Form.Input addon={IconPlate} placeholder="AB123CD" />
      <Form.AdditionalContent>
        <div className="text-s-book">Custom message</div>
      </Form.AdditionalContent>
    </Form.Item>

    <Form.Item hint="Hint message" id="two">
      <Form.Label subText="Add your plate number">Plate Number</Form.Label>
      <Form.Input addon={IconPlate} placeholder="AB123CD" />
    </Form.Item>

    <Form.Item errorMessage="Error message" id="three">
      <Form.Label>Plate Number</Form.Label>
      <Form.Input addon={IconPlate} placeholder="AB123CD" />
    </Form.Item>

    <Form.Item id="four">
      <Form.Label>Password</Form.Label>
      <Form.Input addon={IconLock} addonPlacement="append" placeholder="Write your strong password" type="password" />
    </Form.Item>

    <Form.Item id="five">
      <Form.Label>Area</Form.Label>
      <Form.Input addon="mq" addonPlacement="append" min={10} max={100} defaultValue={70} type="number" />
    </Form.Item>
  </Form>
);
