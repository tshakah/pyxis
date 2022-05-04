import React, {FC} from "react";
import classNames from "classnames";
import styles from "./TextSwitch.module.scss"

// TODO: remove this implementation when TextSwitch will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.

const setWrapperClass = (alt:boolean, labelPosition: LabelPosition):string => classNames(
  "text-switch-wrapper",
  {
    "text-switch-wrapper--alt": alt,
    "text-switch-wrapper--left-label": labelPosition === "left",
    "text-switch-wrapper--top-left-label": labelPosition === "topLeft",
  }
)

const setTextSwitchClass = (optionWidth: OptionWidth):string => classNames(
  "text-switch",
  { "text-switch--equal-option-width": optionWidth === "equal" }
)

const setOptionClass = (checked:boolean):string => classNames(
  "text-switch__option",
  { "text-switch__option--checked": checked }
)

const Option: FC<OptionProps> = (
  {
    checked = false,
    id,
    name,
    onChange = () => {},
    text
  }) =>
    <label className={setOptionClass(checked)}>
      <input
        type="radio"
        name={name}
        className="text-switch__option-input"
        checked={checked}
        id={`option-${name}-${id}`}
        onChange={onChange}
      />
      {text}
    </label>

const getElementProperties =
  (element: HTMLDivElement | null):{optNumber:number, containerPadding:number, containerWidth:number} =>
  {
    if(element) {
      const optNumber = element.children.length - 1;
      const containerStyle = window.getComputedStyle(element);
      const containerPadding = parseInt(containerStyle.getPropertyValue('padding-right'));
      const columnGap = parseInt(containerStyle.getPropertyValue('column-gap'))
      const containerWidth = element.offsetWidth - ( 2 * containerPadding) - columnGap * (optNumber - 1);
      return {optNumber, containerPadding, containerWidth};
    }
    return {optNumber:1, containerPadding:0, containerWidth:1}
}

const TextSwitch:FC<TextSwitchProps> =
  ({
     name,
     optionWidth= "inherit",
     alt= false,
     hasLabel,
     labelPosition= "topCenter"
  }) => {
  const [activeIndex, setActiveIndex] = React.useState(0);
  const [sliderPos, setSliderPos] = React.useState({width: 0, offsetLeft: 0});
  const switchContainerRef = React.useRef<HTMLDivElement>(null);

  React.useLayoutEffect(
    () => {
      const activeElement = switchContainerRef?.current?.children[activeIndex] as HTMLLabelElement
      const {optNumber, containerPadding, containerWidth} = getElementProperties(switchContainerRef?.current)
      setSliderPos({
        offsetLeft: activeElement.offsetLeft - containerPadding,
        width: optionWidth === "equal" ? containerWidth / optNumber : activeElement?.offsetWidth
      })
    }, [switchContainerRef, activeIndex]
  )

  return (
    <div className={setWrapperClass(alt, labelPosition)}>
      {hasLabel && <label className="text-switch__label" id="label-id">Label</label>}
      <div
        className={setTextSwitchClass(optionWidth)}
        role="radiogroup"
        aria-label={!hasLabel ? "custom label" : ""}
        aria-labelledby={hasLabel ? "label-id" : ""}
        ref={switchContainerRef}
      >
        <Option
          name={name}
          checked={activeIndex === 0}
          id="0"
          onChange={() => setActiveIndex(0)}
          text="Opt."
        />
        <Option
          name={name}
          checked={activeIndex === 1}
          id="1"
          onChange={() => setActiveIndex(1)}
          text="Long option"
        />
        <Option
          name={name}
          checked={activeIndex === 2}
          id="2"
          onChange={() => setActiveIndex(2)}
          text="Option"
        />
        <div
          className="text-switch__slider"
          style={{
            width: `${sliderPos.width}px`,
            transform: `translateX(${sliderPos.offsetLeft}px)`}}
        />
      </div>
    </div>
  );
}

const TextSwitches = () =>
  <div className={styles.wrapper}>
    <TextSwitch name={"default"}/>
    <TextSwitch name={"equal"} optionWidth="equal"/>
    <TextSwitch name={"label"} hasLabel />
    <TextSwitch name={"labelTop"} hasLabel labelPosition="topLeft" />
    <TextSwitch name={"labelLeft"} hasLabel labelPosition="left" />
    <div className="padding-xs bg-neutral-base">
      <TextSwitch name={"alt"} alt hasLabel/>
    </div>
  </div>

type LabelPosition = "topCenter" | "topLeft" | "left";

type OptionWidth = "equal" | "inherit";

interface OptionProps {
  checked:boolean;
  id:string;
  name:string;
  onChange: () => void;
  text:string;
}

interface TextSwitchProps {
  name:string;
  optionWidth?: OptionWidth;
  labelPosition?: LabelPosition;
  hasLabel?: boolean;
  alt?: boolean;
}

export default TextSwitches;
