import React, { useState } from "react";
import carSeatIcon from "../../icons/carSeat.svg";
import carWheelIcon from "../../icons/carWheel.svg";
import { VehicleData } from "../../types/VehicleData";
import { fetchNui } from "../../utils/fetchNui";
import IconButton from "./IconButton";

interface Props {
  vehicleData: VehicleData | undefined;
}

const Seats: React.FC<Props> = React.memo(({ vehicleData }) => {
  const currentSeat = !vehicleData?.currSeat ? 1 : vehicleData.currSeat + 1;

  const [isButtonDisabled, setIsButtonDisabled] = useState(false);

  const handleButtonClick = (index: number) => {
    if (!isButtonDisabled) {
      setIsButtonDisabled(true);
      fetchNui("vehmenu:setseat", index);
      setTimeout(() => {
        setIsButtonDisabled(false);
      }, 500);
    }
  };

  return (
    <>
      <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] flex-grow px-4 py-1 rounded-[2px]">
        <div className="flex flex-col gap-2 justify-center items-center font-main">
          <p className="bg-gradient-to-r px-6 py-1  mt-1 rounded-[2px] from-[#2f323d] via-[#3d3f49] to-[#292c37] text-[#2fffd2] font-bold">
            Seats
          </p>
          <div className="grid grid-cols-2 gap-2 mb-1">
            {Array.from({
              length: !vehicleData?.seats ? 4 : vehicleData.seats,
            }).map((_seat, index) => {
              return (
                <>
                  <IconButton
                    key={index}
                    onClick={() => {
                      handleButtonClick(index);
                    }}
                    disabled={isButtonDisabled}
                    isActive={currentSeat === index}
                    svg={index === 0 ? carWheelIcon : carSeatIcon}
                  />
                </>
              );
            })}
          </div>
        </div>
      </div>
    </>
  );
});

export default Seats;
