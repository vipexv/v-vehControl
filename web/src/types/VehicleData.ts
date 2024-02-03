export interface VehicleData {
  seats: number;
  doors: number;
  isDriver: boolean;
  currSeat: number;
  engineOn: boolean;
  indicatorLights: number;
  openDoors: number[],
  closedWindows: number[]
}