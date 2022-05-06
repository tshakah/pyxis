import React, {FC} from "react";
import classNames from "classnames";
import placeholder from "stories/assets/placeholder.svg"
import {IconCar, IconChevronDown} from "components/Icon/Icons";

// TODO: remove this implementation when autocomplete will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.

const setAccordionItemClass = (alt:boolean, color:string):string => classNames(
  'accordion-item',
  {
    'accordion-item--alt': alt,
    'accordion-item--light': color === "white"
  }
)

const setActionIconClass = (isExpanded:boolean):string => classNames(
  'accordion-item__header__action-icon',
  {'accordion-item__header__action-icon--open': isExpanded}
)

const setPanelClass = (isExpanded:boolean):string => classNames(
  'accordion-item__panel',
  {'accordion-item__panel--open': isExpanded}
)

const AccordionItem:FC<AccordionItemProps> =
  ({
     isExpanded,
     id,
     onClick,
     alt,
     color,
     hasIcon,
     hasImage,
     hasSubtext,
     hasActionText
  }) => {
  const panelContentRef = React.useRef<HTMLDivElement>(null);
  const [maxHeightPanel, setMaxHeightPanel] = React.useState(panelContentRef?.current?.offsetHeight || 0);
  const headerId = `${id}-header`;
  const sectId = `${id}-section`;

  React.useLayoutEffect(
    () => {
      const updateSize = () => setMaxHeightPanel(panelContentRef?.current?.offsetHeight || 0);
      window.addEventListener('resize', updateSize);
      updateSize();
      return () => window.removeEventListener('resize', updateSize);
    }, [panelContentRef]
  )

  return (
    <div className={setAccordionItemClass(alt, color)}>
      {/*
        NB: Please use a proper `h*` tag.
      */}
      <h6>
        <button
          id={headerId}
          aria-expanded={isExpanded}
          aria-controls={sectId}
          className="accordion-item__header"
          onClick={() => onClick(id)}
        >
          {hasIcon && <div className="accordion-item__header__addon"><IconCar size="l" /></div>}
          {hasImage && <div className="accordion-item__header__addon">
            <img src={placeholder} width={60} height={60} alt=""/>
          </div>}
          <div className="accordion-item__header__content-wrapper">
            <div className="accordion-item__header__title">Title</div>
            {hasSubtext && <div className="accordion-item__header__subtitle">Subtitle</div>}
          </div>
          <div className="accordion-item__header__action-wrapper">
            {hasActionText && <span className="accordion-item__header__action-label">Action</span>}
            <span className={setActionIconClass(isExpanded)}><IconChevronDown size="l"/></span>
          </div>
        </button>
      </h6>
      <section
        aria-labelledby={headerId}
        className={setPanelClass(isExpanded)}
        id={sectId}
        style={{maxHeight: isExpanded ? maxHeightPanel : 0}}
      >
        <div className={"accordion-item__panel__inner-wrapper"} ref={panelContentRef}>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc non aliquet nisi.
          Phasellus blandit posuere magna. Sed convallis nunc nunc, id posuere justo gravida ut.
          Duis vel consectetur arcu. Sed blandit urna arcu, id tincidunt nunc ornare nec. Pellentesque quam ante,
          mattis sed condimentum a, aliquam sollicitudin nunc. Nullam a semper ligula. Mauris sit amet pulvinar odio.
        </div>
      </section>
    </div>);
}

const Accordion:FC<AccordionProps> =
  ({
    alt= false,
    color= "default",
    id,
    hasIcon = false,
    hasImage = false,
    hasSubtext = true,
    hasActionText = false,
    onlyItem= false
  }) => {
  /* Accordion component should implement both this logic (all the accordion items could be opened at once)
  * and the exclusive one (just one accordion open at time)
  * */
  const initialState = onlyItem ? [] : [`${id}-first`];
  const itemIds = onlyItem ? [`${id}-first`] : [`${id}-first`, `${id}-second`];
  const [expandedItems, setExpandedItems] = React.useState<string[]>(initialState)
  const checkIsExpanded = (id:string):boolean => expandedItems.some((el) => el === id);
  const handleClick = (id:string) => {
    if (expandedItems.some((el) => el === id)) {
      setExpandedItems(expandedItems.filter((el) => el !== id))
    }
    else {
      setExpandedItems([...expandedItems, id])
    }
  }
  return (
    <div className="accordion">
      {itemIds.map(
        el => (
          <AccordionItem
            alt={alt}
            color={color}
            isExpanded={checkIsExpanded(el)}
            id={el}
            onClick={handleClick}
            hasIcon={hasIcon}
            hasImage={hasImage}
            hasSubtext={hasSubtext}
            hasActionText={hasActionText}
            key={el}
          />
        )
      )}
    </div>
  );
}

interface AccordionItemProps {
  alt: boolean;
  color: "default" | "white";
  isExpanded: boolean;
  id: string;
  onClick: (id:string) => void;
  hasIcon: boolean;
  hasImage: boolean;
  hasSubtext: boolean;
  hasActionText: boolean;
}

interface AccordionProps {
  alt?: boolean;
  color?: "default" | "white";
  hasIcon?: boolean;
  hasImage?: boolean;
  hasSubtext?: boolean;
  hasActionText?: boolean;
  id:string;
  onlyItem?:boolean;
}

export default Accordion;
