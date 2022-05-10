import breakpointsToken from '@primauk/tokens/json/breakpoints.json';
import containersToken from '@primauk/tokens/json/containers.json';

const fluidContainer = '100vw - 40px'

export const breakpoints:LayoutRow[] = Object.entries(breakpointsToken).flatMap(([name, value]) => ({
  name,
  value
}));

const responsiveContainers:LayoutRow[] = Object.entries(containersToken.responsiveSize).flatMap(([name, value]) => ({
  name,
  value
}));

export const containerWithFixedWidth:LayoutRow[] = Object.entries(containersToken.fixedSize).flatMap(([name, value]) => ({
  name,
  value
}));

const getContainerValueByBpName = (bpName: string) =>
  responsiveContainers.filter(container => container.name === bpName)[0]?.value;

export const breakpointsWithContainer: LayoutRow[] = breakpoints.map(({name, value}) => ({
  name,
  value,
  maxWidth: getContainerValueByBpName(name) ? `${getContainerValueByBpName(name)}px` : fluidContainer
}));


export interface LayoutRow {
  name: string,
  value: number,
  maxWidth?: number | string,
}
