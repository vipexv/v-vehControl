import {
  AlertTriangle,
  ArrowLeft,
  ArrowRight,
  Lightbulb,
  Power,
} from "lucide-react";
import React, { useState } from "react";
import { VehicleData } from "../../types/VehicleData";
import { fetchNui } from "../../utils/fetchNui";
import IconButton from "./IconButton";

interface Props {
  vehicleData: VehicleData | undefined;
}

const MiscellaneousActions: React.FC<Props> = React.memo(({ vehicleData }) => {
  const [isButtonDisabled, setIsButtonDisabled] = useState(false);

  const handleButtonClick = (option: object) => {
    if (!isButtonDisabled) {
      setIsButtonDisabled(true);
      fetchNui("vehmenu:toggleoption", option);
      setTimeout(() => {
        setIsButtonDisabled(false);
      }, 500);
    }
  };

  return (
    <>
      <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] w-full h-[10dvh] rounded-[2px]">
        <div className="flex flex-col gap-2 justify-center items-center font-main">
          <p className="bg-gradient-to-r px-10 py-1 mt-2 rounded-[2px] from-[#2f323d] via-[#3d3f49] to-[#292c37] text-[#2fffd2] font-bold">
            Miscellaneous
          </p>
          <div className="flex w-full justify-center items-center gap-2 text-white">
            <IconButton
              onClick={() => {
                handleButtonClick({
                  option: "engine",
                });
              }}
              Icon={Power}
              disabled={!vehicleData?.isDriver || isButtonDisabled}
              isActive={!!vehicleData?.engineOn}
            />
            <IconButton
              onClick={() => {
                handleButtonClick({
                  option: "left_blinker",
                });
              }}
              Icon={ArrowLeft}
              disabled={!vehicleData?.isDriver || isButtonDisabled}
              isActive={[1, 3].includes(
                vehicleData?.indicatorLights ? vehicleData?.indicatorLights : 0
              )}
            />
            <IconButton
              onClick={() => {
                handleButtonClick({
                  option: "alert",
                });
              }}
              Icon={AlertTriangle}
              disabled={!vehicleData?.isDriver || isButtonDisabled}
              isActive={vehicleData?.indicatorLights === 3}
            />
            <IconButton
              onClick={() => {
                handleButtonClick({
                  option: "right_blinker",
                });
              }}
              Icon={ArrowRight}
              disabled={!vehicleData?.isDriver || isButtonDisabled}
              isActive={[2, 3].includes(
                vehicleData?.indicatorLights ? vehicleData?.indicatorLights : 0
              )}
            />
            <IconButton
              onClick={() => {
                handleButtonClick({
                  option: "interior_light",
                });
              }}
              Icon={Lightbulb}
              disabled={!vehicleData?.isDriver || isButtonDisabled}
              isActive={
                vehicleData?.interiorLight ? vehicleData.interiorLight : false
              }
            />
          </div>
        </div>
      </div>
    </>
  );
});

export default MiscellaneousActions;
