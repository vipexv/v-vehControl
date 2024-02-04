import React, { useState } from "react";
import doorIcon from "../../icons/cardoor.svg";
import hoodIcon from "../../icons/carhood.svg";
import trunkIcon from "../../icons/trunk.svg";
import { VehicleData } from "../../types/VehicleData";
import { fetchNui } from "../../utils/fetchNui";
import IconButton from "./IconButton";

interface Props {
  vehicleData: VehicleData | undefined;
}

const Doors: React.FC<Props> = React.memo(({ vehicleData }) => {
  const openDoors = !vehicleData?.openDoors ? [0, 1] : vehicleData.openDoors;

  const [disabledButton, setDisabledButton] = useState<number | undefined>(
    undefined
  );

  const handleButtonClick = (index: number) => {
    if (!disabledButton) {
      setDisabledButton(index);
      fetchNui("vehmenu:toggledoor", index);
      setTimeout(() => {
        setDisabledButton(undefined);
      }, 500);
    }
  };

  return (
    <>
      <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] px-4 py-1 rounded-[2px]">
        <div className="flex flex-col gap-2 justify-center items-center font-main">
          <p className="bg-gradient-to-r px-6 py-1  mt-1 rounded-[2px] from-[#2f323d] via-[#3d3f49] to-[#292c37] text-[#2fffd2] font-bold">
            Doors
          </p>
          <div className="flex flex-col gap-2 items-center">
            <IconButton
              onClick={() => {
                handleButtonClick(4);
              }}
              disabled={!vehicleData?.isDriver || disabledButton === 4}
              isActive={openDoors.includes(4)}
              loading={disabledButton === 4}
              svg={hoodIcon}
            />
            <div className="grid grid-cols-2 gap-2">
              {Array.from({
                length: !vehicleData?.doors ? 4 : vehicleData.doors,
              }).map((_seat, index) => {
                return (
                  <>
                    <IconButton
                      key={index}
                      onClick={() => {
                        handleButtonClick(index);
                      }}
                      disabled={
                        !vehicleData?.isDriver || disabledButton === index
                      }
                      isActive={openDoors.includes(index)}
                      loading={disabledButton === index}
                      svg={doorIcon}
                    />
                  </>
                );
              })}
            </div>
            <IconButton
              onClick={() => {
                handleButtonClick(5);
              }}
              disabled={!vehicleData?.isDriver || disabledButton === 5}
              isActive={openDoors.includes(5)}
              loading={disabledButton === 5}
              svg={trunkIcon}
            />
          </div>
        </div>
      </div>
    </>
  );
});

export default Doors;
