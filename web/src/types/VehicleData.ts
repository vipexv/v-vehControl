export interface VehicleData {
  seats: number;
  doors: number;
  currSeat: number;
  engineOn: boolean;
  indicatorLights: number;
  openDoors: number[],
  closedWindows: number[],
  interiorLight: boolean;
}